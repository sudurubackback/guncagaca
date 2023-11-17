package backend.sudurukbackx6.storeservice.domain.reviews.service.dto;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.store.client.dto.GeocodingDto;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@NoArgsConstructor
@Getter
public class ReviewDto {

    @Getter
    @Setter
    public static class Request {
        private Double star;
        private String comment;

    }

    @Getter
    public static class Response {
        private Long reviewId;
        private Double star;
        private String comment;
        private Long memberId;

        public Response(Review review) {
            this.reviewId = review.getId();
            this.star = review.getStar();
            this.comment = review.getComment();
            this.memberId = review.getMemberId();
        }
    }

}
