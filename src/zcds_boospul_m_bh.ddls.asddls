@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #MIXED

define view entity ZCDS_BOOSPUL_M_BH
  as select from zbh_boosupl_m

  association to parent ZCDS_BOOKING_M_BH as _Booking
      on  $projection.TravelId  = _Booking.TravelId
      and $projection.BookingId = _Booking.BookingId

  association [1..1] to ZCDS_TRAVEL_M as _Travel
      on $projection.TravelId = _Travel.TravelId

  association [1..1] to /DMO/I_Supplement as _Product
      on $projection.SupplementId = _Product.SupplementID

  association [1..*] to /DMO/I_SupplementText as _SupplementText
      on $projection.SupplementId = _SupplementText.SupplementID

{
      key travel_id                as TravelId,

      key booking_id               as BookingId,

      key booking_supplement_id    as BookingSupplementId,

      supplement_id                as SupplementId,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                        as Price,

      currency_code                as CurrencyCode,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at              as LastChangedAt,

      _Booking ,
      _Travel,
      _Product,
      _SupplementText
}
