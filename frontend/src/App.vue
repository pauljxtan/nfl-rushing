<template>
  <div class="container">
    <h1>NFL Rushing</h1>
    <Rushes />
  </div>
</template>

<script>
import Rushes from "@/components/Rushes.vue";

export default {
  name: "App",
  components: {
    Rushes,
  },
};
</script>

<style>
body {
  font-family: "DM Sans", sans-serif;
}
</style>
