<template>
  <div>
    <h2>数值计算器</h2>
    <form @submit.prevent="calculate">
      <div>
        <label for="baseCritRate">初始暴击率:</label>
        <input type="number" v-model="baseCritRate" id="baseCritRate" step="0.01" required>
      </div>
      <div>
        <label for="baseCritDamage">初始暴击伤害:</label>
        <input type="number" v-model="baseCritDamage" id="baseCritDamage" step="0.01" required>
      </div>
      <div>
        <label for="baseAttack">角色攻击白值:</label>
        <input type="number" v-model="baseAttack" id="baseAttack" step="0.01" required>
      </div>
      <div>
        <label for="weaponAttack">武器攻击白值:</label>
        <input type="number" v-model="weaponAttack" id="weaponAttack" step="0.01" required>
      </div>
      <button type="submit">计算</button>
    </form>
    <div v-if="result">
      <h3>计算结果</h3>
      <p>总暴击率: {{ result.totalCritRate }}</p>
      <p>总暴击伤害: {{ result.totalCritDamage }}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      baseCritRate: 0,
      baseCritDamage: 0,
      baseAttack: 0,
      weaponAttack: 0,
      result: null
    };
  },
  methods: {
    calculate() {
      const totalCritRate = this.baseCritRate + 0.08; // 示例计算逻辑
      const totalCritDamage = this.baseCritDamage + 0.00; // 示例计算逻辑
      this.result = { totalCritRate, totalCritDamage };
    }
  }
}
</script>

<style>
form div {
  margin-bottom: 1em;
}
</style>
