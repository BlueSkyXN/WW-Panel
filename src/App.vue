<template>
  <div id="app">
    <h1>游戏数值计算器</h1>
    <GameCalculator />
  </div>
</template>

<script>
import GameCalculator from './components/GameCalculator.vue';

export default {
  name: 'App',
  components: {
    GameCalculator
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
