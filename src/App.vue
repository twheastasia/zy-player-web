<template>
  <div id="app" :class="appTheme">
    <Aside />
    <div class="zy-body">
      <!-- 最小化按钮和关闭按钮，web版不用 -->
      <!-- <Frame /> -->
      <Film v-if="view === 'Film'" />
      <Play v-if="view === 'Play'" />
      <Star v-if="view === 'Star'" />
      <Setting v-if="view === 'Setting'" />
    </div>
    <transition name="slide">
      <Detail v-if="detail.show"/>
    </transition>
    <transition name="slide">
      <Share v-if="share.show"/>
    </transition>
  </div>
</template>

<script>
import setting from './lib/dexie/setting'

export default {
  name: 'App',
  data () {
    return {
      appTheme: 'theme-light'
    }
  },
  computed: {
    view () {
      return this.$store.getters.getView
    },
    detail () {
      return this.$store.getters.getDetail
    },
    share () {
      return this.$store.getters.getShare
    },
    theme () {
      return this.$store.getters.getTheme
    }
  },
  watch: {
    theme () {
      this.changeTheme()
    }
  },
  mounted () {
    setting.find().then(res => {
      this.appTheme = `theme-${res.theme}`
    })
  },
  methods: {
    changeTheme () {
      this.appTheme = `theme-${this.theme}`
    }
  }
}
</script>

<style lang="scss">
@import './assets/scss/theme.scss';
html, body, #app{
  border-radius: 6px;
  // 铺满屏幕
  width: 100%;
  height: 100%;
}
#app {
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', SimSun, sans-serif;
  -webkit-font-smoothing: antialiased;
  -webkit-tap-highlight-color: transparent;
  width: 100%;
  height: 100%;
  overflow: hidden;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  .zy-body{
    flex: 1;
    height: 100%;
    display: flex;
    justify-content: flex-start;
    align-items: flex-start;
    flex-direction: column;
    padding: 20px 20px;
  }
}
</style>
