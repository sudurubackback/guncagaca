package backend.sudurukbackx6.storeservice.domain.reviews.service.dto;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class MyReviewResponse {
    private Long id;
    private Double star;
    private String comment;
    private Long storeId;
    private String name;
    private String address;
    private String tel;
    private String img;
    private String description;
    private Double starPoint;

}
