//
//  SideOpeningsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct SideOpeningsSidebar: View {
    
    @Binding var selection: String?
    
    var body: some View {
        ScrollView(.vertical) {
            DisclosureGroup {
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Openings")
                }
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Holes")
                }
            } label: {
                Text("Front")
            }
            DisclosureGroup {
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Openings")
                }
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Holes")
                }
            } label: {
                Text("Rear")
            }
            DisclosureGroup {
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Openings")
                }
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Holes")
                }
            } label: {
                Text("Left")
            }
            DisclosureGroup {
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Openings")
                }
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Holes")
                }
            } label: {
                Text("Right")
            }
            DisclosureGroup {
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Openings")
                }
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Holes")
                }
            } label: {
                Text("Top")
            }
            DisclosureGroup {
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Openings")
                }
                DisclosureGroup {
                    Text("1")
                    Text("2")
                } label: {
                    Text("Holes")
                }
            } label: {
                Text("Bottom")
            }
            // Spacer()
        }
    }
}

struct SideOpeningsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        SideOpeningsSidebar(selection: .constant(nil))
    }
}
