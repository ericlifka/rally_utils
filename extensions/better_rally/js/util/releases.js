(function () {
    var releasesStore = null;
    var getReleaseNamesFromStore = function (store) {
        var releases = [
        ];
        store.each(function (record) {
            var name = record.get("Name");
            releases.push({displayValue:name, value:record.get("_ref")});
        });

        return trimReleasesToFuture(releases);
    };

    var trimReleasesToFuture = function (releases) {
        var today = new Date();

        var trimmedReleases = [
            {displayValue:'No Entry', value:''}
        ];
        Ext4.Array.forEach(releases, function (release) {
            if (new Date(Date.parse(release.displayValue)) >= (today - 1)) {
                trimmedReleases.push(release);
            }
        });
        return trimmedReleases;
    };

    var releasesLoading = false;

    window.RallyUtil = window.RallyUtil || {};
    window.RallyUtil.getReleases = function (callback) {
        if (releasesLoading) {
            setTimeout(function () {
                RallyUtil.getReleases(callback);
            }, 1000);
            return;
        }

        if (releasesStore) {
            callback(getReleaseNamesFromStore(releasesStore));
            return;
        }

        releasesLoading = true;
        Rally.data.ModelFactory.getModel({
            type:"Release",
            success:function (model) {
                releasesStore = Ext4.create("Ext.data.Store", {
                    fetch:["Name"],
                    model:model
                });
                releasesStore.load({callback:function () {
                    releasesLoading = false;
                    callback(getReleaseNamesFromStore(releasesStore));
                }});
            }
        });
    };
})();