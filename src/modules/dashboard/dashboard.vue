<template>
    <lightbox name="dashboard">
        <h1>{{ $m('name') }}</h1>
        <tabs>
            <tab :title="$m('tabs.chart-summary')">
                <chart-summary></chart-summary>
            </tab>
            <tab :title="$m('tabs.vehicle-types')">
                <vehicle-types></vehicle-types>
            </tab>
            <tab :title="$m('tabs.building-types')">
                <building-types></building-types>
            </tab>
            <tab :title="$m('tabs.dispatchcenter-view')">
                <dispatchcenter-view></dispatchcenter-view>
            </tab>
        </tabs>
    </lightbox>
</template>

<script lang="ts">
import Vue from 'vue';

import type { DashboardMethods } from 'typings/modules/Dashboard/Dashboard';
import type { DefaultData, DefaultProps } from 'vue/types/options';

export default Vue.extend<
    DefaultData<Vue>,
    DashboardMethods,
    { premium: boolean },
    DefaultProps
>({
    name: 'lssmv4-dashboard',
    components: {
        DispatchcenterView: () =>
            import(
                /* webpackChunkName: "modules/dashboard/dispatchcenter-view" */ './components/dispatchcenter-view.vue'
            ),
        VehicleTypes: () =>
            import(
                /* webpackChunkName: "modules/dashboard/vehicle-types" */ './components/vehicle-types.vue'
            ),
        BuildingTypes: () =>
            import(
                /* webpackChunkName: "modules/dashboard/building-types" */ './components/building-types.vue'
            ),
        ChartSummary: () =>
            import(
                /* webpackChunkName: "modules/dashboard/chart-summary" */ './components/chart-summary.vue'
            ),
        Lightbox: () =>
            import(
                /* webpackChunkName: "modules/components/lightbox" */ '../../components/lightbox.vue'
            ),
    },
    computed: {
        premium() {
            return window.user_premium;
        },
    },
    methods: {
        $m(key, args) {
            return this.$t(`modules.dashboard.${key}`, args);
        },
    },
});
</script>

<style scoped lang="sass">
.vue-tablist .vue-tab[aria-disabled="true"]
    .premiumNotice
        display: none
        position: absolute
        width: 200%
        font-weight: normal
        z-index: 1

    &:hover .premiumNotice
        display: unset
</style>
