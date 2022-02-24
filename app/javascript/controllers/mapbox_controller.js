import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      // style: "mapbox://styles/mapbox/streets-v10"
      style: "mapbox://styles/kierandunch/cl019o3cv000d15pbhg5nfk6j"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
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
      const customMarker = document.createElement("i")
      customMarker.className = "fa-brands fa-galactic-republic"
      customMarker.style.fontSize = "30px"
      customMarker.style.color = "red"
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
