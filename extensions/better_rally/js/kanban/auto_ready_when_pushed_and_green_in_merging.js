(function () {
    var autoReadyWhenPushedAndGreenInMerging = function (d) {
        var $pushedToMaster = $('input.editPushed:checked', d);
        if ($pushedToMaster.length > 0) {
            var buildStatusData = RallyUtil.fetchBuildStatusData();
            var canMarkReady = true;
            _.each(buildStatusData, function (buildData, buildName) {
                if (buildData.lastBuildStatus !== "SUCCESS") {
                    canMarkReady = false;
                }
            });
            if (canMarkReady) {
                $pushedToMaster.each(function () {
                    var $card = $(this).parents('.card');
                    if (!$card.hasClass('ready')) {
                        $card.find('.readyIndicator').click();
                    }
                });
            }
        }
    };

    RallyUtil.waitForIframeElementsAndExecute(['input.editPushed:checked'], autoReadyWhenPushedAndGreenInMerging, 300000);
})();