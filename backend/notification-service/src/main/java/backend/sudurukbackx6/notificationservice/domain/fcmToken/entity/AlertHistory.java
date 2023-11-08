package backend.sudurukbackx6.notificationservice.domain.fcmToken.entity;


import backend.sudurukbackx6.notificationservice.common.BaseTimeEntity;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
public class AlertHistory extends BaseTimeEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private String title;

	private String body;

	private String imageUrl;

	private String productCode;

	private Long memberId;

	@Builder
	public AlertHistory(Long id, String title, String body, String imageUrl, String productCode, Long memberId) {
		this.id = id;
		this.title = title;
		this.body = body;
		this.imageUrl = imageUrl;
		this.productCode = productCode;
		this.memberId = memberId;
	}
}
