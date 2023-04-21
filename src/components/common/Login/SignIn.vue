<script lang="ts" setup>
import { computed, ref } from 'vue'
import { NButton, NInput, useMessage } from 'naive-ui'
import { useUserStore } from '@/store'
import { t } from '@/locales'

const userStore = useUserStore()

const ms = useMessage()

const userInfo = computed(() => userStore.userInfo)

const avatar = ref(userInfo.value.avatar ?? '')

const name = ref(userInfo.value.name ?? '')

function login() {
  // userStore.resetUserInfo()
  ms.success(t('login.success'))
  window.location.reload()
}
</script>

<template>
  <div class="p-4 space-y-5 min-h-[400px]">
    <div class="space-y-6">
      <div class="flex items-center justify-center space-x-4">
        <div class="w-[200px]">
          <NInput
            v-model:value="avatar" :placeholder="t('login.accountHint')"
            type="text"
          />
        </div>
      </div>
      <div class="flex items-center justify-center space-x-4">
        <div class="w-[200px]">
          <NInput v-model:value="name" :placeholder="t('login.passwordHint')" type="password" />
        </div>
      </div>

      <div class="flex items-center justify-center space-x-4 ">
        <NButton
          type="primary" @click="login"
        >
          {{ $t('login.signIn') }}
        </NButton>
      </div>
    </div>
  </div>
</template>
