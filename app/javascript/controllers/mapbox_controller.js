import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    // Put this in a if statement
    // Look at this.markersValue if i do have markers, create the map with the markers
    // console.log(this.markersValue.length !== 0)
    // console.log(this.markersValue !== [])
    // if (this.markersValue !== []) {
    // Else
    if (this.markersValue.length !== 0) {
      this.map = new mapboxgl.Map({
        container: this.element,
        // style: "mapbox://styles/mapbox/streets-v10"
        style: "mapbox://styles/kierandunch/ckzzngzx3000815lqunln2okg"
      })
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    } else {
      // It can be wahtever I want
        this.element.insertAdjacentHTML("afterbegin", "<h4>Sorry, we could not find what you are looking for</h4>")
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
