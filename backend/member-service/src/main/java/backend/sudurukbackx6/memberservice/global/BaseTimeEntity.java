package backend.sudurukbackx6.memberservice.global;

import lombok.Getter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Column;
import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@EntityListeners(value = {AuditingEntityListener.class})
@MappedSuperclass // 자식에 매핑(db에 반영x)
@Getter
public abstract class BaseTimeEntity {

	@CreatedDate
	@Column(updatable = false)
	public LocalDateTime createTime;

	@LastModifiedDate
	public LocalDateTime updateTime;

}
