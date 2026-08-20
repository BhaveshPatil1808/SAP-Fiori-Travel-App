@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Projection'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #MIXED

@Metadata.allowExtensions: true
define root view entity Z_PV_TRAVEL_M
  provider contract transactional_query
  as projection on ZCDS_TRAVEL_M
{
    key TravelId,

    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookinfFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    
    @ObjectModel.text.element: [ 'OverallStatusText' ]
    OverallStatus,
          
    _OverallStatus._Text.Text as OverallStatusText : localized,
    
    OverallStatusCritically,
    
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,

    /* Associations */

    _Booking : redirected to composition child Z_PV_BOOKING_M_BH,
    
    _Agency,
    _Customer,
    _Currency,
    _OverallStatus
}
