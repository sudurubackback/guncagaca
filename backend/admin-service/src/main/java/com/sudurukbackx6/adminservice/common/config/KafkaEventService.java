package com.sudurukbackx6.adminservice.common.config;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.stereotype.Service;
import org.springframework.util.concurrent.ListenableFuture;
import org.springframework.util.concurrent.ListenableFutureCallback;

@AllArgsConstructor
@Service
@Slf4j
public class KafkaEventService {

    private final KafkaTemplate<String, String> kafkaTemplate;

//    public void eventPublish(String topic, OrderEvent event) throws JsonProcessingException {
//        ObjectMapper objectMapper = new ObjectMapper();
//        String jsonMessage = objectMapper.writeValueAsString(event);
//
//        ListenableFuture<SendResult<String, String>> result = kafkaTemplate.send(topic, jsonMessage);
//
//        result.addCallback(new ListenableFutureCallback<SendResult<String, String>>() {
//            @Override
//            public void onFailure(Throwable ex) {
//                log.error("Unable to send message=[{}] due to : {}", jsonMessage, ex.getMessage());
//            }
//
//            @Override
//            public void onSuccess(SendResult<String, String> result) {
//                log.info("Sent message=[{}] with offset=[{}]", jsonMessage, result.getRecordMetadata().offset());
//            }
//        });
//    }
}
