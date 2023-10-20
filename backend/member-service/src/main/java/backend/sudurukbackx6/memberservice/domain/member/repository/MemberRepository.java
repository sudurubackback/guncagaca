package backend.sudurukbackx6.memberservice.domain.member.repository;

import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long> {
}
