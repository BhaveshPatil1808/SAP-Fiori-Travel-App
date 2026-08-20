@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Projection'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #MIXED

@Metadata.allowExtensions: true
define view entity Z_PV_BOOSPUL_M_BH
  //provider contract transactional_query
  as projection on ZCDS_BOOSPUL_M_BH
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    

    SupplementId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    LastChangedAt,

    /* Associations */

     _Booking : redirected to parent Z_PV_BOOKING_M_BH,
    _Travel : redirected to Z_PV_TRAVEL_M,
    _Product,
    _SupplementText
}
