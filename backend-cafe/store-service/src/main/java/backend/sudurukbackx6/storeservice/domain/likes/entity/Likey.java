package backend.sudurukbackx6.storeservice.domain.likes.entity;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Likey {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "like_id")
    private Long id;

    private Long memberId;

    @ManyToOne(fetch = FetchType.LAZY)
    private Store store;

    @Builder
    public Likey(Long id, Long memberId, Store store) {
        this.id = id;
        this.memberId = memberId;
        this.store = store;
    }
}
