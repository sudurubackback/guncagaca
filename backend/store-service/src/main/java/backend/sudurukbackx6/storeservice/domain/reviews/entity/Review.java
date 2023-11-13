package backend.sudurukbackx6.storeservice.domain.reviews.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.global.BaseTimeEntity;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Review extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private Long id;

    @Column(nullable = false)
    private Double star;

    @Column(nullable = false,columnDefinition = "VARCHAR(500)")
    private String comment;

    @ManyToOne(fetch = FetchType.LAZY)
    private Store store;

    private Long memberId;

    private String orderId;

    @Builder
    public Review(Long id, Double star, String comment, Store store, Long memberId, String orderId) {
        this.id = id;
        this.star = star;
        this.comment = comment;
        this.store = store;
        this.memberId = memberId;
        this.orderId = orderId;
    }
}
