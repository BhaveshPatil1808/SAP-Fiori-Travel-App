# ✈️ SAP Fiori Travel Management App

> **Your Journey, Our Responsibility**  
> A modern, end‑to‑end travel management solution built with **SAP Fiori Elements** and **ABAP RAP**.

![SAP Fiori](https://img.shields.io/badge/UI-SAP%20Fiori-blue?style=for-the-badge)
![ABAP RAP](https://img.shields.io/badge/Backend-ABAP%20RAP-orange?style=for-the-badge)
![OData V2](https://img.shields.io/badge/API-OData%20V2-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

---

## 🌍 Overview
The **SAP Fiori Travel App** is a full‑stack enterprise application that simplifies travel request management.  
It combines the **power of ABAP RAP (RESTful Application Programming Model)** with the **elegance of SAP Fiori Elements**, delivering a responsive, data‑driven experience for travel agencies and customers.

---

## 🧩 Architecture
<img width="474" height="262" alt="image" src="https://github.com/user-attachments/assets/f08bd094-d1f7-45ab-94f1-6c3ea629e5c6" />


<img width="3494" height="2086" alt="image" src="https://github.com/user-attachments/assets/49de5c42-6ace-4794-a4d4-2fc4c9f4fe71" />


| Layer        | Technology             | Description |
|--------------|------------------------|-------------|
| **Frontend** | SAPUI5 / Fiori Elements | List Report & Object Page templates with custom actions |
| **Backend**  | ABAP RAP               | CDS Views, Behavior Definitions, and Business Logic |
| **Integration** | OData V2 Service    | Published via `Z_SB_BH_TRAVEL_001` |
| **Database** | Transparent Tables     | `ZBH_TRAVEL_M`, `ZBH_BOOKING_M`, `ZBH_BOOSUPL_M` |


---

## 🚀 Features

| Feature | Description |
|---------|-------------|
| **Travel Management** | Create, view, and approve travel requests |
| **Booking Handling** | Manage flight bookings and connections |
| **Supplement Tracking** | Add and monitor booking supplements |
| **Smart Validations** | Prevent invalid date ranges via `checkDates` |
| **Auto Calculations** | Compute total price dynamically with `calculateTotalPrice` |
| **Custom Actions** | “Accept Travel” button integrated with backend logic |
| **Responsive UI** | Works seamlessly on desktop, tablet, and mobile |

---

## 🛠️ Installation & Setup

### 🔹 Backend (ABAP RAP)
1. Import the package `Z_FIORI_BH_001` into your ABAP system.  
2. Activate all CDS views, behavior definitions, and service definitions.  
3. Publish the OData service binding `Z_SB_BH_TRAVEL_001`.  
4. Test the endpoint: /sap/opu/odata/sap/Z_SB_BH_TRAVEL_001/

---


### 🔹 Frontend (SAPUI5)
1. Clone the repository and navigate to the `travel1` folder.  
2. Install dependencies:  
```bash
npm install
```
---

### Run the app locally:
```
npm start
```

---


### Access the app at http://localhost:8080 or deploy to SAP Launchpad.


---


## 📂 Project Structure

### Frontend (`travel1`)
```
travel1/
│── webapp/
│   │── annotations/        # Stores UI annotations
│   │── ext/                # Custom controller extensions
│   │── i18n/               # Localization files
│   │── localService/       # Mock data & metadata
│   │── Component.js        # Bootstraps the app
│   │── index.html          # Entry point
│   │── manifest.json       # App metadata & data sources
│   │── ui5.yaml            # UI5 tooling configuration
```



### Backend (`Z_FIORI_BH_001`)

```
Z_FIORI_BH_001/
│── Database Tables
│   │── ZBH_TRAVEL_M
│   │── ZBH_BOOKING_M
│   │── ZBH_BOOSUPL_M
│
│── CDS Views
│   │── ZCDS_TRAVEL_M
│   │── ZCDS_BOOKING_M_BH
│   │── ZCDS_BOOSPUL_M_BH
│
│── Behavior Definitions
│   │── ZBP_CDS_TRAVEL_M
│   │── ZBP_CDS_BOOKING_M_BH
│   │── ZBP_CDS_BOOSPUL_M_BH
│
│── Service Definition
│   │── Z_SD_TRAVEL_001
│
│── Service Binding
│   │── Z_SB_BH_TRAVEL_001
```

---

## 🛠️ Backend (ABAP RAP)

### 📂 Database Tables
| Table | Purpose |
|-------|---------|
| `ZBH_TRAVEL_M` | Stores travel requests (agency, customer, dates, fees, status) |
| `ZBH_BOOKING_M` | Stores booking details (flight, carrier, connection, price, status) |
| `ZBH_BOOSUPL_M` | Stores booking supplements (extra services, price, currency) |

---

### 📂 CDS Views
| View | Purpose |
|------|---------|
| `ZCDS_TRAVEL_M` | Root view for travel entity with associations to bookings, agency, customer, currency, and status |
| `ZCDS_BOOKING_M_BH` | Booking view with associations to travel, customer, carrier, connection, and booking status |
| `ZCDS_BOOSPUL_M_BH` | Booking supplement view with associations to booking, travel, product, and supplement text |

---

### 📂 Projection Views
| Projection | Purpose |
|------------|---------|
| `Z_PV_TRAVEL_M` | Travel projection view for Fiori consumption (includes localized status text, associations) |
| `Z_PV_BOOKING_M_BH` | Booking projection view for Fiori (includes flight info, booking status, supplements) |
| `Z_PV_BOOSPUL_M_BH` | Booking supplement projection view for Fiori (includes supplement info, price, currency) |

---

### 📂 UI Annotations
| Entity | Highlights |
|--------|------------|
| `Z_PV_TRAVEL_M` | Facets for Travel Info, Dates, Price, Admin; Header datapoints for Total Price & Status; Line items with criticality indicators |
| `Z_PV_BOOKING_M_BH` | Facets for Booking Info, Flight Info, Booking Status; Line items for bookings; Supplements as nested line items |
| `Z_PV_BOOSPUL_M_BH` | Facets for Supplement Info & Price; Line items for supplements; Associations hidden for cleaner UI |

---

### 📂 Behavior Definitions
| Entity | Logic |
|--------|-------|
| `ZCDS_TRAVEL_M` | Create/Update/Delete; Validation `checkDates` (BeginDate ≤ EndDate); Determination `calculateTotalPrice` (auto compute fee + base cost) |
| `ZCDS_BOOKING_M_BH` | Update/Delete; Associations to Travel & Supplements; Mandatory BookingId |
| `ZCDS_BOOSPUL_M_BH` | Update/Delete; Associations to Travel & Booking; Mandatory BookingSupplementId |

---

### 📂 Service Definition
| Service | Purpose |
|---------|---------|
| `Z_SD_TRAVEL_001` | Exposes Travel, Booking, BookingSupplement, and related value helps (Agency, Customer, Carrier, Connection, Flight, Airport, Status, Currency, Country) |

---

### 📂 Service Binding
| Binding | Purpose |
|---------|---------|
| `Z_SB_BH_TRAVEL_001` | Publishes OData V2 service for SAP Fiori frontend consumption |

---

### 🎨 UI Highlights


| UI Element | Description |
|---|---|
| **List Report** | Filter travel records by status — **All, Open, Accepted** |
| **Object Page** | Display detailed travel information, including **bookings and supplements** |
| **Charts** | Visualize **agency-wise total price** |
| **Criticality Indicators** | Apply **dynamic color coding** based on travel status |

---

## 🧠 Business Logic Summary

| Function | Description |
|---|---|
| **checkDates** | Validates that Begin Date ≤ End Date |
| **calculateTotalPrice** | Auto-adds booking fee + base cost |
| **acceptButton** *(optional)* | Updates travel status to **“Accepted”** |
| **Associations** | `_Booking`, `_BookSupplement`, `_Travel` link the related entities |

---


## 💡 Key Technologies
SAP Fiori Elements

SAPUI5 (v1.145.3)

ABAP RAP Framework

OData V2 Services

Eclipse ADT for ABAP Development

---

## 🤝 Contributing
Pull requests are welcome!
If you’d like to enhance UI features or backend logic, open an issue first to discuss your ideas.

---

## 📜 License
This project is licensed under the MIT License — feel free to use, modify, and share.


---

## ❤️ Credits
Developed by Bhavesh Patil  
Guided by the principle: “Your Journey, Our Responsibility.”


---
## Application Details
|               |
| ------------- |
|**Generation Date and Time**<br>Thu Aug 06 2026 10:56:32 GMT+0000 (Coordinated Universal Time)|
|**App Generator**<br>SAP Fiori Application Generator|
|**App Generator Version**<br>1.30.0|
|**Generation Platform**<br>SAP Business Application Studio|
|**Template Used**<br>List Report Page V2|
|**Service Type**<br>SAP System (ABAP Cloud)|
|**Service URL**<br>https://bb8534dd-13b7-4042-bba9-41728e5288ac.abap.us10.hana.ondemand.com/sap/opu/odata/sap/Z_SB_FIORI_TRAVEL_001|
|**Module Name**<br>travel1|
|**Application Title**<br>App Title|
|**Namespace**<br>|
|**UI5 Theme**<br>sap_horizon|
|**UI5 Version**<br>1.145.3|
|**Enable TypeScript**<br>False|
|**Add Eslint configuration**<br>True, see https://www.npmjs.com/package/@sap-ux/eslint-plugin-fiori-tools#rules for the eslint rules.|
|**Main Entity**<br>Travel|
|**Navigation Entity**<br>to_OverallStatus|

## travel1

An SAP Fiori application.

### Starting the generated app

-   This app has been generated using the SAP Fiori tools - App Generator, as part of the SAP Fiori tools suite.  To launch the generated application, run the following from the generated application root folder:

```
    npm start
```

- It is also possible to run the application using mock data that reflects the OData Service URL supplied during application generation.  In order to run the application with Mock Data, run the following from the generated app root folder:

```
    npm run start-mock
```

#### Pre-requisites:

1. Active NodeJS LTS (Long Term Support) version and associated supported NPM version.  (See https://nodejs.org)


