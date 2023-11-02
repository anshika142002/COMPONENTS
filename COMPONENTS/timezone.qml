import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "Timezone Clock"

    property string lastTime: ""

    ColumnLayout {

        TextField {
            id: timeZoneInput
            placeholderText: "Enter Timezone (e.g., Europe/Berlin)"
            Layout.fillWidth: true
        }

        Text {
            id: currentTimeText
            color: "red"
            text: "Current Time: "
        }
    }

    Timer {
        id: timeFetcher
        interval: 1000 // Update time every 1 second
        running: true
        repeat: true
        onTriggered: {
            if (timeZoneInput.text !== "") {
                fetchTimeForTimezone()
            }
        }
    }

    function fetchTimeForTimezone() {
        var timezone = timeZoneInput.text
        var url = "http://worldtimeapi.org/api/timezone/" + timezone
        var request = new XMLHttpRequest()
        request.open("GET", url)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    var isoTimeString = response.utc_datetime;
                    if (isoTimeString !== lastTime) {
                        currentTimeText.text = "Current Time: " + Qt.formatDateTime(new Date(isoTimeString), "yyyy-MM-dd hh:mm:ss");
                        lastTime = isoTimeString;
                    }
                } else {
                    currentTimeText.text = "Error fetching time";
                }
            }
        }
        request.send()

    }
}




//Asia/Jerusalem
//Asia/Kabul
//Asia/Kamchatka
//Asia/Karachi
//Asia/Kathmandu
//Asia/Khandyga
//Asia/Kolkata
//Asia/Krasnoyarsk
//Asia/Kuching
//Asia/Macau
//Asia/Magadan
//Asia/Makassar



//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Layouts 1.15

//ApplicationWindow {
//    visible: true
//    width: 400
//    height: 200
//    title: "Timezone Clock"

//    property string lastTime: ""

//    ColumnLayout {
//        ComboBox {
//            id: timeZoneComboBox
//            placeholderText: "Select Timezone"
//            Layout.fillWidth: true
//            model: ListModel {
//                ListElement { text: "America/Bogota" }
//                ListElement { text: "America/Boise" }
//                ListElement { text: "America/Cambridge_Bay" }
//                ListElement { text: "America/Campo_Grande" }
//                ListElement { text: "America/Cancun" }
//                ListElement { text: "America/Caracas" }
//                ListElement { text: "America/Cayenne" }
//            }
//            onCurrentIndexChanged: {
//                if (timeZoneComboBox.currentText !== "") {
//                    fetchTimeForTimezone(timeZoneComboBox.currentText)
//                }
//            }
//        }

//        Text {
//            id: currentTimeText
//            color: "red"
//            text: "Current Time: "
//        }
//    }

//    Timer {
//        id: timeFetcher
//        interval: 1000 // Update time every 1 second
//        running: true
//        repeat: true
//        onTriggered: {
//            if (timeZoneComboBox.currentText !== "") {
//                fetchTimeForTimezone(timeZoneComboBox.currentText)
//            }
//        }
//    }

//    function fetchTimeForTimezone(timezone) {
//        var url = "http://worldtimeapi.org/api/timezone/" + timezone
//        var request = new XMLHttpRequest()
//        request.open("GET", url)
//        request.onreadystatechange = function() {
//            if (request.readyState === XMLHttpRequest.DONE) {
//                if (request.status === 200) {
//                    var response = JSON.parse(request.responseText);
//                    var isoTimeString = response.utc_datetime;
//                    if (isoTimeString !== lastTime) {
//                        currentTimeText.text = "Current Time: " + Qt.formatDateTime(new Date(isoTimeString), "yyyy-MM-dd hh:mm:ss");
//                        lastTime = isoTimeString;
//                    }
//                } else {
//                    currentTimeText.text = "Error fetching time";
//                }
//            }
//        }
//        request.send()
//    }
//}
