<script setup lang='ts'>
import { computed, ref } from 'vue'
import { NModal, NTabPane, NTabs } from 'naive-ui'
import SignIn from './SignIn.vue'
import SignUp from './SignUp.vue'
import { SvgIcon } from '@/components/common'

interface Props {
  visible: boolean
}

interface Emit {
  (e: 'update:visible', visible: boolean): void
}

const props = defineProps<Props>()

const emit = defineEmits<Emit>()

const active = ref('SignIn')

const show = computed({
  get() {
    return props.visible
  },
  set(visible: boolean) {
    emit('update:visible', visible)
  },
})
</script>

<template>
  <NModal v-model:show="show" :auto-focus="false" preset="card" style="width: 95%; max-width: 600px">
    <div class="space-y-4">
      <NTabs v-model:value="active" class="justify-center" type="segment" animated>
        <NTabPane name="SignIn" tab="SignIn">
          <template #tab>
            <SvgIcon class="text-lg" icon="ri:user-line" />
            <span class="ml-2">{{ $t('setting.signIn') }}</span>
          </template>

          <div class="min-h-[100px]">
            <SignIn />
          </div>
        </NTabPane>
        <NTabPane name="SignUp" tab="SignUp">
          <template #tab>
            <SvgIcon class="text-lg" icon="ri:file-user-line" />
            <span class="ml-2">{{ $t('setting.signUp') }}</span>
          </template>
          <div class="min-h-[100px]">
            <SignUp />
          </div>
        </NTabPane>
      </NTabs>
    </div>
  </NModal>
</template>
