package backend.sudurukbackx6.storeservice.domain.reviews.service.dto;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
public class MyReviewResponse {
    private Long id;
    private Double star;
    private String comment;
    private Long storeId;
    private String storeName;
    private double starTotal;
    private String img;


    public MyReviewResponse(Review review) {
        this.id = review.getId();
        this.star = review.getStar();
        this.comment = review.getComment();
        this.storeId = review.getStore().getId();
        this.storeName = review.getStore().getName();
        this.starTotal = review.getStore().getStarPoint();
        this.img = review.getStore().getImg();
    }
}
