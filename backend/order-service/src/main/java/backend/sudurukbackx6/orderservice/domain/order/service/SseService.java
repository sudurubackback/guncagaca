package backend.sudurukbackx6.orderservice.domain.order.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class SseService {

    private final Map<Long, SseEmitter> emitterMap = new ConcurrentHashMap<>();
    private final ScheduledExecutorService executorService = Executors.newScheduledThreadPool(1);

    public SseService() {
        // 주기적으로 모든 SseEmitter에 하트비트 메시지 전송
        executorService.scheduleAtFixedRate(this::sendHeartbeat, 0, 30, TimeUnit.SECONDS);
    }

    private void sendHeartbeat() {
        emitterMap.forEach((storeId, emitter) -> {
            try {
                emitter.send(SseEmitter.event().comment("heartbeat"));
            } catch (IOException e) {
                emitter.completeWithError(e);
                emitterMap.remove(storeId);
            }
        });
    }

    public SseEmitter createEmitter(Long storeId) {
        log.info("sse 등록");
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        emitterMap.put(storeId, emitter);
        return emitter;
    }

    public void sendToStoreClients(Long storeId, Object data) {
        log.info("주문 생성됨");
        SseEmitter emitter = emitterMap.get(storeId);
        if(emitter != null) {
            try {
                emitter.send(data);
            } catch (IOException e) {
                emitterMap.remove(storeId);
            }
        }
    }
}
