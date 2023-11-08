package backend.sudurukbackx6.storeservice.domain.store.entity;

import java.util.List;

import javax.persistence.*;

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

    @OneToMany(mappedBy = "store", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Review> reviews;

    @OneToMany(mappedBy = "store")
    private List<Likey> likeys;

    @Builder
    public Store(Long id, String name, Double latitude, Double longitude, String address, String tel, String img,
                 String openTime, String closeTime, String description, List<Review> review) {
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
        this.reviews = review;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
