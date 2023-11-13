package backend.sudurukbackx6.storeservice.domain.store.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import backend.sudurukbackx6.storeservice.domain.likes.entity.Likey;
import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import lombok.*;

@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    private Long id;

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String name;

    private Double latitude;

    private Double longitude;

    @Column(nullable = false,columnDefinition = "VARCHAR(500)")
    private String address;

    @Column(nullable = false)
    private String tel;

    @Column(columnDefinition = "VARCHAR(500)")
    private String img;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private Double starPoint;

    @Column(nullable = false)
    private boolean isOpen;

    private String openTime;

    private String closeTime;

    @OneToMany(mappedBy = "store")
    private List<Review> reviews;

    @OneToMany(mappedBy = "store")
    private List<Likey> likeys;

    @Builder
    public Store(Long id, String name, Double latitude, Double longitude, String address, String tel, String img,
                 String openTime, String closeTime, String description, List<Review> reviews) {
        this.id = id;
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
        this.address = address;
        this.tel = tel;
        this.img = img;
        this.isOpen = false;
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.starPoint = 0.0;
        this.description = description;
        this.reviews = reviews;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
