package backend.sudurukbackx6.storeservice.domain.reviews.service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class ReviewSaveRequest {
	private int star;
	private String content;
}
