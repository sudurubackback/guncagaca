package backend.sudurukbackx6.storeservice.domain.store.client.dto;

import lombok.Getter;

import java.util.List;

public class GeocodingDto {

    @Getter
    public static class Request {
        private String query;

    }

    @Getter
    public class Response {
        private String status;
        private List<Address> addresses;
        private String errorMessage;

        @Getter
        public class Address {
            private String roadAddress;
            private String jibunAddress;
            private String x;
            private String y;
        }
    }

}
