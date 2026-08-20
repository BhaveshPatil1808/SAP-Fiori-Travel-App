sap.ui.define([
    "sap/m/MessageBox",
    "sap/m/MessageToast"
], function (MessageBox, MessageToast) {
    "use strict";

    return {

        onInit: function () {

            MessageToast.show(
                "Welcome to the Bhavesh Travel Application!"
            );

            MessageBox.information(
                "Welcome to the Bhavesh Travel Application!",
                {
                    title: "Bhavesh Travel App"
                }
            );
        },


        onMyButtonPress: function () {

            var oExtensionAPI = this.extensionAPI;

            var aSelectedContexts =
                oExtensionAPI.getSelectedContexts();

            // No selection
            if (!aSelectedContexts ||
                aSelectedContexts.length === 0) {

                MessageBox.warning(
                    "Please select a Travel first."
                );

                return;
            }

            // Take first selected Travel
            var oContext = aSelectedContexts[0];

            // Get Travel data
            var oTravel = oContext.getObject();

            var sTravelId = oTravel.TravelId || "";
            var sAgencyId = oTravel.AgencyId || "";
            var sCustomerId = oTravel.CustomerId || "";
            var sStatus = oTravel.OverallStatus || "";

            // Show popup
            MessageBox.confirm(
                "Do you want to accept this Travel?\n\n" +
                "Travel ID: " + sTravelId + "\n" +
                "Agency ID: " + sAgencyId + "\n" +
                "Customer ID: " + sCustomerId + "\n" +
                "Current Status: " + sStatus,

                {
                    title: "Accept Travel",

                    actions: [
                        MessageBox.Action.OK,
                        MessageBox.Action.CANCEL
                    ],

                    emphasizedAction: MessageBox.Action.OK,

                    onClose: function (sAction) {

                        if (sAction === MessageBox.Action.OK) {

                            MessageToast.show(
                                "Travel accepted successfully!"
                            );

                        }

                    }
                }
            );
        }

    };
});