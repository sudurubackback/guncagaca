package backend.sudurukbackx6.storeservice.global.kafka;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/kafka")
@RequiredArgsConstructor
public class KafkaController {

    private final KafkaEventService kafkaEventService;

    @GetMapping("/publish/test")
    public void publishTest() {
        String message = "test";

        kafkaEventService.eventPublish("test", message);

    }
}
