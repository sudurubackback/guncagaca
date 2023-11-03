package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.domain.owner.client.OrderServiceClient;
import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.SalesSummaryResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.StoreOrderResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.GetTodaySellingResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Transactional
@Service
public class OwnerStatisticsService {

}
