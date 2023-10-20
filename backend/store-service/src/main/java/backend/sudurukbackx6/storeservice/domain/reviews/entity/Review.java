package backend.sudurukbackx6.storeservice.domain.reviews.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Review {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false)
	private int star;

	@Column(nullable = false,columnDefinition = "VARCHAR(500)")
	private String comment;

	@ManyToOne(fetch = FetchType.LAZY)
	private Store store;

	private Long memberId;

	@Builder
	public Review(Long id, int star, String comment, Store store, Long memberId) {
		this.id = id;
		this.star = star;
		this.comment = comment;
		this.store = store;
		this.memberId = memberId;
	}
}
