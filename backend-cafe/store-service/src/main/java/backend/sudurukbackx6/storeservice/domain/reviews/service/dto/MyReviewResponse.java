package backend.sudurukbackx6.storeservice.domain.reviews.service.dto;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class MyReviewResponse {

    private Double star;
    private String comment;
    private Store store;
}
