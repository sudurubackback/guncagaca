package backend.sudurukbackx6.storeservice.domain.likes.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LikeToggleResponse {
    private Long storeId;
    private boolean isLiked;
}
