package backend.sudurukbackx6.storeservice.domain.store.client;

import backend.sudurukbackx6.storeservice.domain.store.client.dto.OwnerInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.ChangeOwnerStoreIdRequest;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@FeignClient(url = "k9d102.p.ssafy.io:8086", name="owner-service")
//@FeignClient(url = "http://localhost:8086", name="owner-service")
public interface OwnerServiceClient {
    @GetMapping("/api/ceo/ownerInfo")
    OwnerInfoResponse getOwnerInfo(@RequestHeader("Authorization") String token);

    @PutMapping("/api/ceo/ownersStore")
    Long changeOwnersStoreId(@RequestBody ChangeOwnerStoreIdRequest request);
}
