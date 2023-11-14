package backend.sudurukbackx6.orderservice.domain.order.service;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class SseService {

    private final Map<Long, SseEmitter> emitterMap = new ConcurrentHashMap<>();

    public SseEmitter createEmitter(Long storeId) {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        emitterMap.put(storeId, emitter);
        return emitter;
    }

    public void sendToStoreClients(Long storeId, Object data) {
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
