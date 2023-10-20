package backend.sudurukbackx6.storeservice.domain.store.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Store {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "store_id")
	private Long id;

	@Column(nullable = false, columnDefinition = "VARCHAR(500)")
	private String name;

	@Column(nullable = false)
	private Double latitude;

	@Column(nullable = false)
	private Double longitude;

	@Column(nullable = false,columnDefinition = "VARCHAR(500)")
	private String address;

	@Column(nullable = false)
	private String tel;

	@Column(columnDefinition = "VARCHAR(500)")
	private String img;

	@Column(nullable = false)
	private String description;

	@OneToMany(mappedBy = "store")
	private List<Review> review;

	@Builder
	public Store(Long id, String name, Double latitude, Double longitude, String address, String tel, String img,
		String description, List<Review> review) {
		this.id = id;
		this.name = name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.address = address;
		this.tel = tel;
		this.img = img;
		this.description = description;
		this.review = review;
	}
}
