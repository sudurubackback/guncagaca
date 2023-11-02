package backend.sudurukbackx6.storeservice.domain.likes.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class LikeResponse {
    private Long memberId;
    private Long storeId;
    private String cafeName;
    private Double starPoint;
    private int reviewCount;
    private String img;
    private boolean isLiked;
    private String description;
}
