package backend.sudurukbackx6.memberservice.domain.member.repository;

import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findByEmail(String email);
    List<Member> findByIdIn(List<Long> ids);
}
