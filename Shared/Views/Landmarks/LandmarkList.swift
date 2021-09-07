import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject
    var modelData: ModelData

    @State
    private var showFavoritesOnly = false

    private var filteredLandmarks: [Landmark] {
        get {
            return showFavoritesOnly
                ? modelData.landmarks.filter { landmark in landmark.isFavorite }
                : modelData.landmarks
        }
    }

    var body: some View {
        NavigationView() {
            List() {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
