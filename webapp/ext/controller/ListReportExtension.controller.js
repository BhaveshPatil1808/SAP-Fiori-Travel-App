sap.ui.define([
    "sap/m/MessageBox"
], function (MessageBox) {
    "use strict";

    return {

        onMyButtonPress: function () {

            MessageBox.success(
                "My custom action was executed successfully!",
                {
                    title: "Travel Action"
                }
            );
        }

    };
});