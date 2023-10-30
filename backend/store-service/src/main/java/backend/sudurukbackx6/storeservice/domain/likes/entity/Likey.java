package backend.sudurukbackx6.storeservice.domain.likes.entity;

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

    private Long storeId;

    @Builder
    public Likey(Long id, Long memberId, Long storeId) {
        this.id = id;
        this.memberId = memberId;
        this.storeId = storeId;
    }
}
