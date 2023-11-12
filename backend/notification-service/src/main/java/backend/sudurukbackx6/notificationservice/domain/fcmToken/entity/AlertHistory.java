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

	private Long memberId;

	private Long storeId;

	@Builder
	public AlertHistory(Long id, String title, String body, Long memberId, Long storeId) {
		this.id = id;
		this.title = title;
		this.body = body;
		this.memberId = memberId;
		this.storeId = storeId;
	}
}
