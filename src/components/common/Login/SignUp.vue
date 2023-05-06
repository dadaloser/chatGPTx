<script lang="ts" setup>
import { computed, ref } from 'vue'
import { NButton, NInput, useMessage } from 'naive-ui'
import { useUserStore } from '@/store'
import { t } from '@/locales'

const userStore = useUserStore()

const ms = useMessage()

const userInfo = computed(() => userStore.userInfo)

const account = ref(userInfo.value.avatar ?? '')

const password = ref(userInfo.value.name ?? '')

const email = ref(userInfo.value.description ?? '')

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
            v-model:value="account" :placeholder="t('login.accountHint')" type="text"
          />
        </div>
      </div>
      <div class="flex items-center justify-center space-x-4">
        <div class="w-[200px]">
          <NInput v-model:value="password" :placeholder="t('login.passwordHint')" type="password" />
        </div>
      </div>
      <div class="flex items-center justify-center space-x-4">
        <div class="w-[200px]">
          <NInput v-model:value="email" :placeholder="t('login.emailHint')" type="text" />
        </div>
      </div>

      <div class="flex items-center justify-center space-x-4 ">
        <NButton size="small" type="primary" @click="login">
          {{ $t('login.signIn') }}
        </NButton>
      </div>
    </div>
  </div>
</template>
