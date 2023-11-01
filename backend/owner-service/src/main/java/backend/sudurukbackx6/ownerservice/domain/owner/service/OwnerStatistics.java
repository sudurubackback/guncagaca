package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.common.error.code.ErrorCode;
import backend.sudurukbackx6.ownerservice.common.error.exception.BadRequestException;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class OwnerStatistics {

    private final OwnersRepository ownersRepository;

    public SellTodayCntResponse sellTodayCnt(String email) {
        Owners owners = ownersRepository.findByEmail(email).orElseThrow(()
                -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));

        

    }
}
