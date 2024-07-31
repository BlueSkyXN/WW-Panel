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
        <input type="number" v-model="baseAttack" id="baseAttack" step="1" required>
      </div>
      <div>
        <label for="weaponAttack">武器攻击白值:</label>
        <input type="number" v-model="weaponAttack" id="weaponAttack" step="1" required>
      </div>
      <div>
        <label for="talentCritRate">天赋暴击率:</label>
        <input type="number" v-model="talentCritRate" id="talentCritRate" step="0.01" required>
      </div>
      <div>
        <label for="talentCritDamage">天赋暴击伤害:</label>
        <input type="number" v-model="talentCritDamage" id="talentCritDamage" step="0.01" required>
      </div>
      <div>
        <label for="extraCritRate">其他暴击率:</label>
        <input type="number" v-model="extraCritRate" id="extraCritRate" step="0.01" required>
      </div>
      <div>
        <label for="extraCritDamage">其他暴击伤害:</label>
        <input type="number" v-model="extraCritDamage" id="extraCritDamage" step="0.01" required>
      </div>
      <div>
        <label for="extraAttackPercent">其他攻击百分比:</label>
        <input type="number" v-model="extraAttackPercent" id="extraAttackPercent" step="0.01" required>
      </div>
      <div>
        <label for="extraAttackFixed">其他攻击固定值:</label>
        <input type="number" v-model="extraAttackFixed" id="extraAttackFixed" step="1" required>
      </div>
      <div>
        <label for="extraElementDamagePercent">其他元素伤害百分比:</label>
        <input type="number" v-model="extraElementDamagePercent" id="extraElementDamagePercent" step="0.01" required>
      </div>
      <button type="submit">计算</button>
    </form>
    <div v-if="result">
      <h3>计算结果</h3>
      <p>总暴击率: {{ result.totalCritRate }}</p>
      <p>总暴击伤害: {{ result.totalCritDamage }}</p>
      <p>总攻击力: {{ result.totalAttack }}</p>
      <p>总元素伤害百分比: {{ result.totalElementDamagePercent }}</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'GameCalculator',
  data() {
    return {
      baseCritRate: 0,
      baseCritDamage: 0,
      baseAttack: 0,
      weaponAttack: 0,
      talentCritRate: 0,
      talentCritDamage: 0,
      extraCritRate: 0,
      extraCritDamage: 0,
      extraAttackPercent: 0,
      extraAttackFixed: 0,
      extraElementDamagePercent: 0,
      result: null
    };
  },
  methods: {
    calculate() {
      const totalCritRate = this.baseCritRate + this.talentCritRate + this.extraCritRate;
      const totalCritDamage = this.baseCritDamage + this.talentCritDamage + this.extraCritDamage;
      const totalAttack = this.baseAttack + this.weaponAttack + (this.baseAttack + this.weaponAttack) * this.extraAttackPercent + this.extraAttackFixed;
      const totalElementDamagePercent = this.extraElementDamagePercent;

      this.result = { totalCritRate, totalCritDamage, totalAttack, totalElementDamagePercent };
    }
  }
}
</script>

<style>
form div {
  margin-bottom: 1em;
}
</style>
