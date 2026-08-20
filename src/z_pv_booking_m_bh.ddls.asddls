@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #MIXED

@Metadata.allowExtensions: true
define view entity Z_PV_BOOKING_M_BH
  //provider contract transactional_query
  as projection on ZCDS_BOOKING_M_BH
{
    key TravelId,
    key BookingId,

    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    LastChangedAt,

    /* Associations */

     _Travel : redirected to parent Z_PV_TRAVEL_M,

  _BookSupplement : redirected to composition child Z_PV_BOOSPUL_M_BH,
    _Customer,
    _Carrier,
    _Connection,
    _BookingStatus
}
