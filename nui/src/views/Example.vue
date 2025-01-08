<template>
    <div>
      <h1>À propos</h1>
      <p>Ceci est la page "À propos".</p>
    </div>
</template>
  

<script setup>
  defineProps({
    pageData: {
      type: Object,
      default: () => ({}),
    },
  });
</script>