<template>
  <v-container>
    <v-row>
      <v-col cols="12">
        <h2>数值计算器</h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12" md="6" v-for="field in fields" :key="field.model">
        <v-text-field
          :label="field.label"
          :type="field.type"
          :step="field.step"
          v-model="field.value"
        ></v-text-field>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title>计算结果</v-card-title>
          <v-card-text>
            <p>总暴击率: {{ totalCritRate }}</p>
            <p>总暴击伤害: {{ totalCritDamage }}</p>
            <p>总攻击力: {{ totalAttack }}</p>
            <p>总元素伤害百分比: {{ totalElementDamagePercent }}</p>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'GameCalculator',
  data() {
    return {
      fields: [
        { label: '初始暴击率', model: 'baseCritRate', value: 0.05, type: 'number', step: 0.01 },
        { label: '初始暴击伤害', model: 'baseCritDamage', value: 1.50, type: 'number', step: 0.01 },
        { label: '角色攻击白值', model: 'baseAttack', value: 462, type: 'number', step: 1 },
        { label: '武器攻击白值', model: 'weaponAttack', value: 587, type: 'number', step: 1 },
        { label: '天赋暴击率', model: 'talentCritRate', value: 0.08, type: 'number', step: 0.01 },
        { label: '天赋暴击伤害', model: 'talentCritDamage', value: 0.00, type: 'number', step: 0.01 },
        { label: '其他暴击率', model: 'extraCritRate', value: 0.25, type: 'number', step: 0.01 },
        { label: '其他暴击伤害', model: 'extraCritDamage', value: 0.00, type: 'number', step: 0.01 },
        { label: '其他攻击百分比', model: 'extraAttackPercent', value: 0.35, type: 'number', step: 0.01 },
        { label: '其他攻击固定值', model: 'extraAttackFixed', value: 0.00, type: 'number', step: 1 },
        { label: '其他元素伤害百分比', model: 'extraElementDamagePercent', value: 0.10, type: 'number', step: 0.01 }
      ]
    };
  },
  computed: {
    totalCritRate() {
      return this.fields.find(field => field.model === 'baseCritRate').value + 
             this.fields.find(field => field.model === 'talentCritRate').value + 
             this.fields.find(field => field.model === 'extraCritRate').value;
    },
    totalCritDamage() {
      return this.fields.find(field => field.model === 'baseCritDamage').value + 
             this.fields.find(field => field.model === 'talentCritDamage').value + 
             this.fields.find(field => field.model === 'extraCritDamage').value;
    },
    totalAttack() {
      const baseAttack = this.fields.find(field => field.model === 'baseAttack').value + 
                        this.fields.find(field => field.model === 'weaponAttack').value;
      return baseAttack + baseAttack * this.fields.find(field => field.model === 'extraAttackPercent').value + 
             this.fields.find(field => field.model === 'extraAttackFixed').value;
    },
    totalElementDamagePercent() {
      return this.fields.find(field => field.model === 'extraElementDamagePercent').value;
    }
  }
}
</script>

<style>
.v-container {
  max-width: 600px;
  margin: 0 auto;
}
</style>
