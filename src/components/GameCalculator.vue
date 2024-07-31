<template>
  <v-container>
    <h1 class="text-center mb-6">攻击x暴击x元素伤害的基值计算器</h1>

    <v-row>
      <v-col cols="12" md="6" v-for="(group, index) in parameterGroups" :key="index">
        <v-card>
          <v-card-title>{{ group.title }}</v-card-title>
          <v-card-text>
            <v-row>
              <v-col cols="12" sm="6" v-for="field in group.fields" :key="field.label">
                <v-text-field
                  :label="field.label"
                  v-model.number="field.value"
                  type="number"
                  :step="field.step || 0.01"
                  outlined
                  dense
                ></v-text-field>
              </v-col>
            </v-row>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <v-card class="mt-6">
      <v-card-title>计算结果</v-card-title>
      <v-card-text>
        <v-row>
          <v-col cols="12" sm="6" md="4" v-for="(result, index) in calculatedResults" :key="index">
            <v-sheet rounded elevation="1" class="pa-4">
              <div class="text-subtitle-1">{{ result.label }}</div>
              <div class="text-h6">{{ result.value.toFixed(3) }}</div>
            </v-sheet>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: 'GameCalculator',
  data() {
    return {
      parameterGroups: [
        {
          title: '基本信息',
          fields: [
            { label: '初始暴击率', value: 0.05, step: 0.01 },
            { label: '初始暴击伤害', value: 1.5, step: 0.01 },
            { label: '角色攻击白值', value: 462, step: 1 },
            { label: '武器攻击白值', value: 587, step: 1 },
          ]
        },
        {
          title: '天赋',
          fields: [
            { label: '天赋暴击率', value: 0.08, step: 0.01 },
            { label: '天赋暴击伤害', value: 0, step: 0.01 },
            { label: '天赋攻击百分比', value: 0.12, step: 0.01 },
            { label: '天赋元素伤害百分比', value: 0, step: 0.01 },
          ]
        },
        {
          title: '武器',
          fields: [
            { label: '武器暴击率', value: 0, step: 0.01 },
            { label: '武器暴击伤害', value: 0.484, step: 0.01 },
            { label: '武器攻击百分比', value: 0.24, step: 0.01 },
            { label: '武器元素伤害百分比', value: 0, step: 0.01 },
          ]
        },
        {
          title: '声骸',
          fields: [
            { label: '声骸暴击率', value: 0.411, step: 0.01 },
            { label: '声骸暴击伤害', value: 1.136, step: 0.01 },
            { label: '声骸攻击百分比', value: 0.69, step: 0.01 },
            { label: '声骸攻击固定值', value: 390, step: 1 },
            { label: '声骸元素伤害百分比', value: 0.6, step: 0.01 },
          ]
        },
        {
          title: '其他',
          fields: [
            { label: '其他暴击率', value: 0.25, step: 0.01 },
            { label: '其他暴击伤害', value: 0, step: 0.01 },
            { label: '其他攻击百分比', value: 0.35, step: 0.01 },
            { label: '其他攻击固定值', value: 0, step: 1 },
            { label: '其他元素伤害百分比', value: 0.1, step: 0.01 },
          ]
        },
      ]
    };
  },
  computed: {
    finalCritRate() {
      return (
        this.basicInfo[0].value + 
        this.talents[0].value + 
        this.weapons[0].value + 
        this.relics[0].value + 
        this.others[0].value
      );
    },
    finalCritDamage() {
      return (
        this.basicInfo[1].value + 
        this.talents[1].value + 
        this.weapons[1].value + 
        this.relics[1].value + 
        this.others[1].value
      );
    },
    finalAttackPercent() {
      return (
        this.talents[2].value + 
        this.weapons[2].value + 
        this.relics[2].value + 
        this.others[2].value
      );
    },
    finalAttackFixed() {
      return this.relics[3].value + this.others[3].value;
    },
    finalElementDamagePercent() {
      return (
        this.talents[3].value + 
        this.weapons[3].value + 
        this.relics[4].value + 
        this.others[4].value
      );
    },
    finalActualAttack() {
      const baseAttack = this.basicInfo[2].value + this.basicInfo[3].value;
      return baseAttack * (1 + this.finalAttackPercent) + this.finalAttackFixed;
    },
    finalDamageBase() {
      const actualAttack = this.finalActualAttack;
      return (
        (actualAttack * this.finalCritRate * this.finalCritDamage + actualAttack * (1 - this.finalCritRate)) * (1 + this.finalElementDamagePercent)
      );
    }
  }
}
</script>

<style scoped>
.v-sheet {
  transition: all 0.3s;
}
.v-sheet:hover {
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}
</style>