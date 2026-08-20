@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #MIXED

define root view entity ZCDS_TRAVEL_M
  as select from zbh_travel_m as Travel

  composition [0..*] of ZCDS_BOOKING_M_BH as _Booking

  association [0..1] to /DMO/I_Agency as _Agency
    on $projection.AgencyId = _Agency.AgencyID

  association [0..1] to /DMO/I_Customer as _Customer
    on $projection.CustomerId = _Customer.CustomerID

  association [0..1] to I_Currency as _Currency
    on $projection.CurrencyCode = _Currency.Currency

  association [0..1] to /DMO/I_Overall_Status_VH as _OverallStatus
    on $projection.OverallStatus = _OverallStatus.OverallStatus

{
      key travel_id  as TravelId,

      agency_id      as AgencyId,

      customer_id    as CustomerId,

      begin_date     as BeginDate,

      end_date       as EndDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      bookinf_fee    as BookinfFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price    as TotalPrice,

      currency_code  as CurrencyCode,


 

      overall_status as OverallStatus,




    
    case overall_status
    when 'O' then 2
    when 'A' then 3
    when 'X' then 1
    else 0
    end       as OverallStatusCritically, 
    
    
    
      description    as Description,

      @Semantics.user.createdBy: true
      created_by     as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at     as CreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      lastchangedby  as LastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat  as LastChangedAt,

      _Booking,
      _Agency,
      _Customer,
      _Currency,
      _OverallStatus
}
