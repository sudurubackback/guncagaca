package backend.sudurukbackx6.orderservice.client;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient("owner-service")
public interface OwnerServiceClient {
}
