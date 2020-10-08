<template>
  <div>
    <div class="form-row">
      <div class="form-group col-md-6">
        <label>Filter by name (case-insensitive)</label>
        <input type="text" class="form-control" v-model="filter_name" />
      </div>
      <div class="form-group col-md-6">
        <label>Page size</label>
        <input type="number" class="form-control" v-model="page_size" />
      </div>
    </div>

    <div class="row mb-3">
      <p class="col-md-5">
        Total players: {{ rushes.length }} (Filtered:
        {{ rushes_filtered_sorted.length }})
      </p>
      <div class="form-row col-md-5">
        <button
          type="button"
          class="col-md-6 btn btn-outline-dark btn-sm"
          :disabled="current_page_idx <= 0"
          @click="current_page_idx -= 1"
        >
          Prev page
        </button>
        <button
          type="button"
          class="col-md-6 btn btn-outline-dark btn-sm"
          :disabled="current_page_idx >= total_pages - 1"
          @click="current_page_idx += 1"
        >
          Next page
        </button>
      </div>
      <div class="col-md-2">
        <p>{{ current_page_idx + 1 }} / {{ total_pages }}</p>
      </div>
    </div>

    <table class="table table-sm table-striped">
      <thead>
        <tr>
          <th>Player</th>
          <th>Team</th>
          <th>Pos</th>
          <th>Att/G</th>
          <th>Att</th>
          <th>
            <a href="#" class="text-primary" @click="change_sort('yards')"
              >Yds</a
            >
          </th>
          <th>Avg</th>
          <th>Yds/G</th>
          <th>
            <a href="#" class="text-primary" @click="change_sort('touchdowns')"
              >TD</a
            >
          </th>
          <th>
            <a href="#" class="text-primary" @click="change_sort('longest')"
              >Lng</a
            >
          </th>
          <th>1st</th>
          <th>1st%</th>
          <th>20+</th>
          <th>40+</th>
          <th>FUM</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="rush in current_page" :key="rush.player">
          <td>{{ rush.player }}</td>
          <td>{{ rush.team }}</td>
          <td>{{ rush.position }}</td>
          <td>{{ rush.attempts_per_game }}</td>
          <td>{{ rush.attempts }}</td>
          <td>{{ rush.yards }}</td>
          <td>{{ rush.yards_per_attempt }}</td>
          <td>{{ rush.yards_per_game }}</td>
          <td>{{ rush.touchdowns }}</td>
          <td>{{ rush.longest }}</td>
          <td>{{ rush.first_downs }}</td>
          <td>{{ rush.first_down_percentage }}</td>
          <td>{{ rush.twenty_plus_yards }}</td>
          <td>{{ rush.forty_plus_yards }}</td>
          <td>{{ rush.fumbles }}</td>
        </tr>
      </tbody>
    </table>

    <button
      type="button"
      class="btn btn-outline-success btn-block"
      @click="download_csv"
    >
      Download as CSV
    </button>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Rushes",

  data: function () {
    return {
      rushes: [],

      page_size: 5,
      current_page_idx: 0,

      sort_by: "yards",
      sort_asc: false,

      filter_name: "",
    };
  },

  mounted: function () {
    this.load_rushes();
  },

  computed: {
    rushes_filtered_sorted: function () {
      let filtered = this.rushes.filter((rush) =>
        rush.player.toLowerCase().includes(this.filter_name)
      );

      if (this.sort_by == "yards") {
        filtered.sort((x, y) => y.yards - x.yards);
      } else if (this.sort_by == "touchdowns") {
        filtered.sort((x, y) => y.touchdowns - x.touchdowns);
      } else if (this.sort_by == "longest") {
        filtered.sort((x, y) => y.longest - x.longest);
      }
      if (this.sort_asc) {
        filtered.reverse();
      }

      return filtered;
    },

    current_page: function () {
      // FIXME Applying a filter might cause the current page number to become out of range
      // In this case, we should probably go back to the last available page

      const idx_start = this.current_page_idx * this.page_size;
      const idx_end = idx_start + parseInt(this.page_size);

      return this.rushes_filtered_sorted.slice(idx_start, idx_end);
    },

    total_pages: function () {
      return Math.ceil(this.rushes_filtered_sorted.length / this.page_size);
    },
  },

  methods: {
    load_rushes: function () {
      axios
        .get("/api/rushes")
        .then((resp) => {
          this.rushes = JSON.parse(resp.data.rushes);
        })
        .catch(() => {
          // This should probably display a nicer notification on the page
          // itself, but yeah...
          alert("API call failed");
        });
    },

    // If already sorting by the same column, flip the order
    // Otherwise, sort by the new column in descending order
    change_sort: function (column) {
      if (this.sort_by == column) {
        this.sort_asc = !this.sort_asc;
      } else {
        this.sort_by = column;
        this.sort_asc = false;
      }
    },

    download_csv: function () {
      const rows = this.rushes_filtered_sorted.reduce(
        (acc, r) =>
          acc +
          `${r.player},${r.team},${r.position},${r.attempts},` +
          `${r.attempts_per_game},${r.yards},${r.yards_per_attempt},` +
          `${r.yards_per_game},${r.touchdowns},${r.longest},${r.first_downs},` +
          `${r.first_down_percentage},${r.twenty_plus_yards},` +
          `${r.forty_plus_yards},${r.fumbles}\n`,
        "Player,Team,Pos,Att,Att/G,Yds,Avg,Yds/G,TD,Lng,1st,1st%,20+,40+,FUM\n"
      );
      const output = "data:text/csv;charset=utf-8," + encodeURIComponent(rows);

      const link = document.createElement("a");
      link.setAttribute("href", output);
      link.setAttribute("download", "rushing.csv");
      link.click();
    },
  },
};
</script>
